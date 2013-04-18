##
# GTools
# Copyright (c) 2013 Kamil Kocemba <kkocemba@gmail.com>
#

require 'spec_helper'

describe GTools do

  describe :page_rank do

    it "should return page rank for a valid domain" do
      page_rank = GTools.page_rank 'google.com'
      page_rank.should_not be_nil
      page_rank.should == 9
    end

    it "should return nil for invalid domain" do
      page_rank = GTools.page_rank 'test'
      page_rank.should be_nil
    end

    it "should raise error for bad URI" do
      lambda {
        GTools.page_rank '!@#$%' 
      }.should raise_error(URI::InvalidURIError)
    end

  end

  describe :pagespeed_analysis do

    it "should return data for a valid domain" do
      data = GTools.pagespeed_analysis 'google.com'
      data["rule_results"].should_not be_nil
      data["score"].should_not be_nil
    end

    it "should return nil for invalid domain" do
      data = GTools.pagespeed_analysis 'test'
      data.should be_nil
    end

  end
   
  describe :pagespeed_score do

    it "should return an integer for a valid domain" do
      score = GTools.pagespeed_score 'google.com'
      score.should_not be_nil
      score.should be_a_kind_of(Fixnum)
    end

    it "should return nil for invalid domain" do
      score = GTools.pagespeed_score 'test'
      score.should be_nil
    end

  end

  describe :site_index do

    it "should return an integer for a valid domain" do
      index = GTools.site_index 'google.com', '50.19.85.156'
      index.should_not be_nil
      index.should_not == 0
    end

    it "should return nil for invalid url" do
      index = GTools.site_index '@#$%', '50.19.85.156'
      index.should be_nil
    end

  end

  describe :site_links do

    it "should return an integer for a valid domain" do
      count = GTools.site_links 'google.com', '50.18.169.106'
      count.should_not be_nil
      count.should_not == 0
    end

    it "should return nil for invalid url" do
      count = GTools.site_links '@#$%', '50.18.169.106'
      count.should be_nil
    end

  end

  describe :search_results do

    it "should return an integer for a valid query" do
      count = GTools.search_results 'lolcat', '199.59.148.82'
      count.should_not be_nil
      count.should_not == 0
    end

    it "should work without providing IP" do
      count = GTools.search_results 'google.com'
      count.should_not be_nil
      count.should_not == 0
    end

  end

  describe :suggested_tld do

    it "should return a string" do
      tld = GTools.suggested_tld
    end

  end

end