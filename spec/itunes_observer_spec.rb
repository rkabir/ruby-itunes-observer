$:.unshift File.dirname(__FILE__)

require 'spec_helper'
require 'osx/cocoa'

include OSX
OSX.require_framework 'ScriptingBridge'

describe ITunesObserver do
  before do
    @itunes = SBApplication.applicationWithBundleIdentifier_("com.apple.iTunes")
    raise 'iTunes should be running' unless @itunes.isRunning
    @result = nil
    @observer = ITunesObserver.new do |result|
      @result = result
    end

    @itunes.stop
  end

  after do
    @itunes.stop
  end

  it "should observe playing" do
    @itunes.playpause
    @observer.run(1)
    @result.should_not be_nil
    @result['Name'].should_not be_nil
  end
end