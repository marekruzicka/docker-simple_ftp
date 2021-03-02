# docker-template - container CICD workflow example

General idea is that you just copy this structure and edit (possibly extend) the container build part (Dockerfile, scripts, configs), and test.sh.  
build.sh, upload.sh, cleanup.sh are reusable without the need for any changes.

## How to use this template
Easiest way to take advantage of this template is:
1. **Clone it**
   via https
```
git clone https://github.com/marekruzicka/docker-template.git
```

2. **Rename docker-template** ('template') directory to reflect your application (keep the 'docker-' part)
```
mv docker-template docker-<name_of_your_app>
```
    and enter the directory
```
cd docker-<name_of_your_app>
```

3. **Remove the existing '.git' directory**
```
rm -rf .git
```

4. **Create new project on GitLab and follow the steps in "Existing folder" part**  
example:
```
git init
git remote add origin <path to your git repo>
git add .
git commit -m "Initial commit"
git push -u origin master
```

5. **Create initial git tag and push it upstream**
```
git tag devel
git push origin --tags
```
You can choose any tag you like (eg. v0.0), but you have to set one.

6. **Enable container registry and setup git strategy in project settings**  
*Settings -> Permissions -> container registry*  enable  
*Settings -> CI/CD -> General pipelines settings -> Git strategy for pipelines* set to **git clone**  
(don't forget to 'save changes' after each step)

7. **Think about how are you going to test your container and edit 'test'sh' accordingly**  
If you skip this step now, your CICD pipeline (automatic test/build workflow will fail by design)

8. **Update the *README.md* file**  
Unless you believe this how to is appropriate for your project as well :)
