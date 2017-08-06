#PENDING TEST AWAITING CONFIGURATION OF mini_magick
# require 'rails_helper'
# require 'carrierwave/test/matchers'
#
# describe ProfilePictureUploader do
#   include CarrierWave::Test::Matchers
#
#   let(:user) { FactoryGirl.create(:user) }
#   let(:uploader) { ProfilePictureUploader.new(user, :profile_picture) }
#
#   describe 'good photo upload' do
#     before do
#       ProfilePictureUploader.enable_processing = true
#       File.open("#{Rails.root}/spec/support/images/good_photo.png") { |f| uploader.store!(f) }
#     end
#
#     after do
#       ProfilePictureUploader.enable_processing = false
#       uploader.remove!
#     end
#
#     it "has the correct format" do
#       expect(uploader).to be_format('png')
#     end
#   end
# end
