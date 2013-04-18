##
# GTools
# Copyright (c) 2013 Kamil Kocemba <kkocemba@gmail.com>
#

require "gtools/version"
require 'httparty'

module GTools

  ##
  # Returns Google Page Rank for specified domain
  #
  # <tt>Note: mining Page Rank violates Google ToS.</tt>
  #
  def self.page_rank(domain)
    url = GToolsConfiguration.tbr_host + GToolsConfiguration.tbr_query % [GMath.hash(domain), domain]
    r = HTTParty.get(url).parsed_response
    (r =~ /(\d+)$/) ? Integer($1) : nil
  end

  ##
  # Returns a dictionary of Google pagespeed analysis results for specified URL.
  # 
  # Notable fields: <tt>rule_results</tt>, <tt>score</tt>
  #
  def self.pagespeed_analysis(url)
    return nil unless valid_url url
    url = GToolsConfiguration.google_pagespeed_url % [URI.encode(url)]
    HTTParty.get(url).parsed_response["results"]
  end

  ##
  # Returns pagespeed score for specified URL.
  # 
  def self.pagespeed_score(url)
    return nil unless valid_url url
    r = pagespeed_analysis(url)
    r ? r["score"] : nil
  end

  ##
  # Returns estimated number of indexed pages for specified domain.
  #
  # <tt>Provide user_ip param to avoid ToS violation.</tt>
  #
  def self.site_index(url, user_ip = nil)
    return nil unless valid_url url
    search_results "site:#{url}", user_ip
  end

  ##
  #
  # Returns a number of results for link:domain query.
  # This gives an overview of backlink portfolio.
  #
  # <tt>Note: this method is not intended to be used for accurate backlink analysis.</tt>
  # 
  def self.site_links(url, user_ip = nil)
    return nil unless valid_url url
    search_results "link:#{url}", user_ip
  end

  ##
  # Returns estimated number of results for specified search query.
  #
  # <tt>Provide user_ip param to avoid ToS violation.</tt>
  #
  def self.search_results(query, user_ip = nil)
    return nil unless query
    url = GToolsConfiguration.google_apisearch_url % [1, URI.encode(query)]
    url += "&userip=#{user_ip}" if user_ip
    r = HTTParty.get(url).parsed_response
    return nil unless r['responseData']
    count = r['responseData']['cursor']['estimatedResultCount']
    count ? Integer(count) : nil
  end

  ##
  # Returns Google tld suggestion based on current IP.
  #
  def self.suggested_tld
    url = GToolsConfiguration.google_tld_url
    domain = HTTParty.get(url).parsed_response
    domain =~ /google\.(.*)$/ ? $1 : nil
  end

  private
  def self.valid_url(url) # :nodoc:
    false unless url
    url += 'http://' unless url =~ /http:\/\//
    !!(URI.parse(url) && url =~ URI::regexp)
  rescue URI::InvalidURIError
    false 
  end

  private
  module GToolsConfiguration # :nodoc:

    class << self; 
      attr_accessor :google_apisearch_url, :google_pagespeed_url, :google_plusone_url, :google_tld_url, :tbr_host, :tbr_query; 
    end
    self.google_apisearch_url = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0&rsz=%s&q=%s"
    self.google_pagespeed_url = "https://developers.google.com/_apps/pagespeed/run_pagespeed?url=%s&format=json"
    self.google_plusone_url = "https://plusone.google.com/u/0/_/+1/fastbutton?count=true&url=%s"
    self.google_tld_url = "https://www.google.com/searchdomaincheck?format=domain&sourceid=navclient-ff"
    self.tbr_host = "http://toolbarqueries.google.com/tbr"
    self.tbr_query = "?features=Rank&client=navclient-auto&ch=%s&q=info:%s"

  end

  private
  module GMath # :nodoc:

    class << self; attr_accessor :hash_seed; end

    self.hash_seed = "Mining PageRank is AGAINST GOOGLE'S TERMS OF SERVICE. Yes, I'm talking to you, scammer."

    def self.urshift(v, amt)
      mask = (1 << (32 - amt)) - 1
      (v >> amt) & mask
    end

    def self.fmod(v, x)
      i = (v / x).floor
      r = Integer(v - Float(i * x))
      r
    end

    def self.hexenc(v)
      x = urshift(v, 24).to_s(16).rjust(2, "0")
      x += (urshift(v, 16) & 255).to_s(16).rjust(2, "0")
      x += (urshift(v, 8) & 255).to_s(16).rjust(2, "0")
      x + (v & 255).to_s(16).rjust(2, "0")
    end

    def self.hash(str)
      v = 16909125
      for i in 0..(str.length - 1)
        v ^= self.hash_seed[i % 87].ord ^ str[i].ord
        v = fmod(v, 0xFFFFFFFF + 1) if 0xFFFFFFFF < v || -0xFFFFFFFF > v
        v -= 0xFFFFFFFF + 1 if 0x7FFFFFFF < v
        v += 0xFFFFFFFF + 1 if -0x80000000 > v
        v = urshift(v, 23) | v << 9
      end
      "8" + hexenc(v)
    end

  end

end
