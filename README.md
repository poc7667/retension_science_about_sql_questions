# Setup database fake data

- rake db:create
- rake db:migrate
- rake prepare_data:events
- rake prepare_data:users
- rake prepare_data:orders

# How to use it under rails console

I've wrote native MySQL query in correspoinding models.

You can get expected results after having prepared sample data in DB

- `Event.get_days_until_next`

![inline](https://i.imgur.com/xodFW8d.png=300x "Title")

- `User.never_has_any_order`

![inline](https://i.imgur.com/t53yu4F.png=300x "Title")
 
# Count the days for the next event

Idea: Use `subquery` to get the next event and call the datediff FUNC to get the day difference

![inline](https://i.imgur.com/LQdKUwA.png=300x "Title")

## Step by step 

- Get the next_dt for the next event

      (SELECT e.*,
         (SELECT dt
          FROM events e2
          WHERE e2.eid = e.eid
            AND e2.dt > e.dt) AS next_dt
       FROM events e)

- add WHERE condition to filter out the unqualified events(that is those events don't have upcoming affairs)

   where next_dt is not null;

- Select the expected columns, and apply `datediff function` to get the remaining days to the next event.

## Whole SQL expression

    SELECT e.eid,
           e.dt,
           datediff(next_dt, dt) AS days_until_next
    FROM
      (SELECT e.*,
         (SELECT dt
          FROM events e2
          WHERE e2.eid = e.eid
            AND e2.dt > e.dt ) AS next_dt
       FROM events e ) e
    WHERE next_dt IS NOT NULL;

# Find the customers who haven't make any order

Idea: use `left join` to get the difference set, please see my handwirting illustration.

## Whole SQL expression

    SELECT users.id
    FROM users
    LEFT JOIN orders ON users.id = orders.user_id
    WHERE orders.id IS NULL

