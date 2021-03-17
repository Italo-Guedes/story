class AddInitialUserAndRoles < ActiveRecord::Migration[4.2]
  def up
  	Role.create name: :admin unless Role.find_by_name(:admin)

    if (User.where(email: "contato@rdmapps.com.br").count == 0)
      u = User.new(email: "contato@rdmapps.com.br", password: "lklklklk", name: "Admin Rdmapps")
      u.confirmed_at = Time.zone.now
      u.save(validate: false)
      u.add_role :super_admin
    end
  end

  def down
  end
end
