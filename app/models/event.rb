class Event < ActiveRecord::Base
    def self.get_days_until_next
        query = <<END
            SELECT e.eid, e.dt, datediff(next_dt, dt) as days_until_next
            from (select e.*,
                         (select dt
                          from events e2
                          where e2.eid = e.eid and e2.dt > e.dt
                         ) as next_dt
                  from events e
                 ) e
            where next_dt is not null;
END
        ActiveRecord::Base.connection.select_all(query)
    end
end