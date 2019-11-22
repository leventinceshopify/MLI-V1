# As you can see, we specify that the mutation can return a token along with a current admin,
# and the only accepted argument is email

module Mutations
  class SignInMutation < Mutations::BaseMutation
    argument :email, String, required: true

    field :token, String, null: true
    field :admin, Types::AdminType, null: true

    def resolve(email:)
      admin = Admin.find_by!(email: email)
      return {} unless admin

      token = Base64.encode64(admin.email)
      {
        token: token,
        admin: admin
      }
    end
  end
end
