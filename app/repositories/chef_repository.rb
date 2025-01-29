class ChefRepository
  class << self

    # create chef
    def create_chef(chef)
      @is_chef_create = chef.save
    end

    # find chef using email
    def find_by_email(email)
      @chef = Chef.find_by(email: email)
    end

    #get chef Id
    def get_chef_by_id(id)
      @chef = Chef.find(id)
    end

    #update chef profile
    def update_chef(chef, chef_params)
      @is_update_chef = chef.update(chef_params)
    end

    #update chef password
    def update_password(chef, password)
      @is_update_password = chef.update_attribute(:password, password)
    end
  end
end
