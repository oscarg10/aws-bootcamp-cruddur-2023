-- this file was manually created
INSERT INTO public.users (display_name, handle, email, cognito_user_id)
VALUES
  ('Oscar Gordillo', 'oscargordillo' , 'oscar_andres16@hotmail.com','fc6c8353-7b8d-4d14-87a7-4219496d576b'),
  ('Andrew Brown', 'andrewbrown' ,'andrewbrown@exampro.com', 'MOCK'),
  ('Andrew Bayko', 'bayko' ,'test@email', 'MOCK')
  ;

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'oscargordillo' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )