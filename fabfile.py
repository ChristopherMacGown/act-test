from fabric import task


@task
def deploy_api(self, *args, **kwargs):
    print("would deploy api!")

@task
def deploy_scheduler(self, *args, **kwargs):
    print("would deploy api!")