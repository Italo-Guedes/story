# frozen_string_literal: true

# Default user roles
Role.create name: :super_admin unless Role.find_by(name: :super_admin)
Role.create name: :admin unless Role.find_by(name: :admin)
Role.create name: :operator unless Role.find_by(name: :operator)

# Initial user
u = User.create(email: 'contato@rdmapps.com.br', password: 'lklklklk', name: 'Admin Rdmapps')
u.confirmed_at = Time.zone.now
u.save(validate: false)
u.add_role :super_admin
