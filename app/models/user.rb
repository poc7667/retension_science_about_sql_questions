class User < ActiveRecord::Base
    has_many :orders
    def self.never_has_any_order
        query = <<SQL_QUERY
            SELECT
            users.id
            FROM users
            LEFT JOIN orders
            ON users.id = orders.user_id
            WHERE orders.id IS NULL
SQL_QUERY
        ActiveRecord::Base.connection.select_all(query)
    end

    def self.who_has_orders
        query = <<SQL_QUERY
            SELECT
            users.id
            FROM users
            LEFT JOIN orders
            ON users.id = orders.user_id
            WHERE orders.id IS NOT NULL
SQL_QUERY
        ActiveRecord::Base.connection.select_all(query)
    end

    scope :who_has_orders_using_scope, -> { joins(:orders) }
    scope :who_has_orders_using_scope_and_outer_join, -> { includes(:orders, :users) }
    #{ where('published_at > ?', Time.now) }
end
