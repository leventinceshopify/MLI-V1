module Mutations
  class UpdateItem < BaseMutation
    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :sku, Integer, required: true
    argument :name, String, required: true
    argument :description, String, required: false
    argument :cost, Float, required: true
    argument :quantity_threshold, Integer, required: true
    argument :size, String, required: false
    argument :manufacturer, String, required: false
    argument :picture, String, required: false


    # return type from the mutation
    # type Types::ProductType
    field :item, Types::ProductType, null: true
    field :errors, [String], null: false

    def resolve(id:, sku:, name: nil,  description: nil, cost:, quantity_threshold:, size:, manufacturer:, picture: nil)
      # if context[:current_admin].nil?
      #   raise GraphQL::ExecutionError,
      #         "You need to authenticate to perform this action"
      # end

      item = Item.find(id)

      if item.update(sku: sku, name: name, description: description, cost: cost, quantity_threshold: quantity_threshold,
                        size: size, manufacturer: manufacturer, picture: picture)
        { item: item }
      else
        { errors: product.errors.full_messages }
      end

    end
  end
end
