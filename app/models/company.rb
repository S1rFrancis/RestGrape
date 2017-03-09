class Company < ActiveRecord::Base
  has_many :services, dependent: :destroy

  before_destroy :destroy_services

   private

   def destroy_services
     self.services.delete_all
   end
end
