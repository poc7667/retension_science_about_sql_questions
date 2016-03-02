# left join

    User.joins(:orders)

    query = <<SQL_QUERY
                SELECT
                *
                FROM users
                LEFT JOIN orders
                ON users.id = orders.user_id
    SQL_QUERY
    ret = ActiveRecord::Base.connection.select_all(query.gsub("\n",''))


# right join    