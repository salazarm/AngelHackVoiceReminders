require 'twilio-ruby'
class TwillioController < ApplicationController
	include TwillioHelper
	before_filter :setup
	
	def trigger
		@call = @client.account.calls.create(
		  :from => '+16173592736',
		  :to => '+13476172295',
		  :url => 'http://pure-falls-2527.herokuapp.com/trigger_reminder?id='+params[:id]
		)
		redirect_to root_url
	end

	def trigger_reminder
		message = @reminder.trigger
		if message
			render :xml => message
		else
	    msg = Twilio::TwiML::Response.new do |r|
	      r.Say 'This reminder is broken'
	    end.text
	    render :xml => msg
		end
	end

	def setup
		account_sid = 'AC8b70300105eb2b524cc293ba3339fc49'
		auth_token = '0947cdfdd17a0cc08e9c088bed3db60a'
		@client = Twilio::REST::Client.new account_sid, auth_token
		@reminder = Reminder.find_by_id(params[:id])
		unless @reminder
			msg = Twilio::TwiML::Response.new do |r|
    		r.Play "http://voicebunny.s3.amazonaws.com/live/624A3694C18735F332E2_ori_dfc1e.wav"
	    end.text
	    render :xml => msg
		end
	end
end
