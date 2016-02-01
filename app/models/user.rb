class User < ActiveRecord::Base
    def self.never_has_any_order
        query = <<END
            SELECT
            users.id
            FROM users
            LEFT JOIN orders
            ON users.id = orders.user_id
            WHERE orders.id IS NULL
END
        ActiveRecord::Base.connection.select_all(query)
    end
end
