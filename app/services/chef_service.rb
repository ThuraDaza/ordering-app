class ChefService
  class << self

    # create chef
    def create_chef(chef)
      @is_chef_create = ChefRepository.create_chef(chef)
    end

    # find chef using email
    def find_by_email(email)
      @chef = ChefRepository.find_by_email(email)
    end

    #get chef Id
    def get_chef_by_id(id)
      @chef = ChefRepository.get_chef_by_id(id)
    end

    #update chef profile
    def update_chef(chef, chef_params)
      @is_chef_update = ChefRepository.update_chef(chef, chef_params)
    end

    #update chef password
    def update_password(chef, password)
      @is_update_password = ChefRepository.update_password(chef, password)
    end
  end
end
