from fabric import task


@task
def deploy_api(self, *args, **kwargs):
    print("would deploy api!")

@task
def deploy_scheduler(self, *args, **kwargs):
    print("would deploy scheduler!")

@task
def deploy_front_end(self, *args, **kwargs):
    print("would deploy front-end!")

@task
def deploy_lambdas(self, *args, **kwargs):
    print("would deploy lambdas")