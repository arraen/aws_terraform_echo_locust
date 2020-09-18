from locust import HttpUser, TaskSet, task

class UserBehavior(TaskSet):
   def on_start(self):
       self.client.post("/login", {"login":"user", "pass":"secret"})

   def on_stop(self):
       self.client.post("/logout", {"login":"user"})

   @task(3)
   def index(self):
       self.client.get("/")

   @task(1)
   def profile(self):
       self.client.get("/account")

class WebsiteUser(HttpUser):
   tasks = [UserBehavior]
   min_wait = 5000
   max_wait = 9000