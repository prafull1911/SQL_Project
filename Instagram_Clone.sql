use ig_clone;
-- 1.Create an ER diagram or draw a schema for the given database.
-- 2.Create an ER diagram or draw a schema for the given database.
select username from users order by created_at limit 5;
-- 3. To understand when to run the ad campaign, figure out the day of the week most users register on? 
select dayname(created_at) as day, count(*) as registered from users group by day order by registered desc ;
-- 4.To target inactive users in an email ad campaign, find the users who have never posted a photo.
select username,u.id,p.id  from users u left join photos p on  u.id=p.user_id where p.id is NULL;
-- 5.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select username,count(l.user_id) as popularity from  users u  join photos p on  u.id=p.user_id 
 join likes l on p.id = l. photo_id group by  p.id order by popularity desc limit 5;
 -- 6. The investors want to know how many times does the average user post.
select (select count(*) from photos)/(select count(*) from users) as avg ;
-- 7. A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select t.tag_name , count(*) as total from tags t join photo_tags pt on t.id=pt.tag_id group by tag_id order by total desc limit 5;
-- 8. To find out if there are bots, find users who have liked every single photo on the site.
select username , count(*) as bot  from users u join likes l on u.id = l.user_id group by user_id having bot = (select max(total)  from (select count(*) as total from likes group by user_id) as like_count) ; 
select max(total)  from (select count(*) as total from likes group by user_id) as bot;
-- 9. To know who the celebrities are, find users who have never commented on a photo.
with temp_celeb as (select  username ,c.id  from users u left join photos p on u.id = p.user_id 
left join comments c on p.id = c.photo_id group by p.id )
select * from temp_celeb where id is null;
-- 10. find the users who have never commented on any photo or have commented on every photo.
with temp_2 as (select user_id ,count(*) as t1  from comments group by user_id)
select username from users u join temp_2 t2 on u.id = t2.user_id where t1=257 ;



 
