-- this file was manually created
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('Oscar Gordillo', 'oscar_andres16@hotmail.com', 'oscargordillo', 'MOCK'),
  ('Andrew Bayko', 'test@email', 'bayko', 'MOCK'),
  ('Londo Mollari','lmollari@centari', 'londo', 'MOCK')
  ;

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'oscargordillo' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )