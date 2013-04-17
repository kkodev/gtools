require 'spec_helper'

describe GTools do

  sleep_amount = 1

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
      sleep sleep_amount
      index = GTools.site_index 'google.com'
      index.should_not be_nil
      index.should_not == 0
    end

    it "should return nil for invalid domain" do
      sleep sleep_amount
      index = GTools.site_index 'test'
      index.should be_nil
    end

  end

  describe :site_links do

    it "should return an integer for a valid domain" do
      sleep sleep_amount
      count = GTools.site_links 'google.com'
      count.should_not be_nil
      count.should_not == 0
    end

    it "should return nil for invalid domain" do
      sleep sleep_amount
      count = GTools.site_links 'test'
      count.should be_nil
    end

  end

  describe :search_results do

    it "should return an integer for a valid domain" do
      sleep sleep_amount
      count = GTools.search_results 'google.com'
      count.should_not be_nil
      count.should_not == 0
    end

    it "should return nil for invalid domain" do
      sleep sleep_amount
      count = GTools.search_results 'test'
      count.should be_nil
    end
  end

  describe :suggested_tld do

    it "should return a string" do
      tld = GTools.suggested_tld
    end

  end

end