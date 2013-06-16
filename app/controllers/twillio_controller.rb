require 'twilio-ruby'
class TwillioController < ApplicationController
	include TwillioHelper
	before_filter :setup
	
	def trigger
		@call = @client.account.calls.create(
		  :from => '+13476172295',
		  :to => '+16173592736',
		  :url => 'http://voicechat.herokuapp.com/trigger_reminder?id='+params[:id]
		)
		sleep(5.seconds)
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
		@reminder = Reminder.last
		unless @reminder
			msg = Twilio::TwiML::Response.new do |r|
	      		r.Play "http://www.terminatorfiles.com/media/audio/t2/hasta-la-vista-baby.wav"
		    end.text
		    render :xml => msg
		end
	end
end
