# How to make website using github pages

## Github Pages
Is service by github to make static website

### Introduction
1. [Jobs require git](https://www.linkedin.com/jobs/search/?currentJobId=3382401033&geoId=102478259&keywords=developer&location=Indonesia&refresh=true)
2. [About Git and Github](https://www.jhsph.edu/research/centers-and-institutes/welch-center-for-prevention-epidemiology-and-clinical-research/events/grand-rounds/presentations/191120%20intro_to_git_github.pdf "Intro to Github")


### Create Account and Repository
1. Open github.com and Sign Up
2. Klik Plus and New Repository
3. Name it with username.github.io
4. make it public
5. Add README.md
6. Create

### Set Up Template for Github Page
1. Choose [Supported Themes](https://pages.github.com/themes/)
2. Go To Usage section
3. Update README.md
4. Go to Settings under Pages Section
5. Make sure you choose branch to be github pages, and you might use custom domain

### Advance Things
1. Using [git-scm](https://git-scm.com/) software
2. Set up key and add to your profile
3. Clone, add, commit, push.

#### Get SSH Key 
to get ssh key in your computer, and put in your github or gitlab ssh key setting.

```sh
cat ~/.ssh/id_rsa.pub
```
if there is not exist you must generate ssh key in next section

#### Generate RSA Key
Just One time for first instalation of git scm, 
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

#### Set config global
Just One time for first instalation of git scm, 

```sh
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

#### Enabling SSH connections over HTTPS

```sh
$ nano ~/.ssh/config
```

```sh
Host github.com
  Hostname ssh.github.com
  Port 443
  User git

Host gitlab.com
  Hostname altssh.gitlab.com
  User git
  Port 443
```

#### Forking repository and keep update from source repo
Please click fork from web interface, after that clone your repo in your desktop. Select SSH in clone tab.

```sh
git clone git@github.com:youruserrepo/geojson.git
```

git bash into your repo folder, just one time add upstream from source of fork repo. Use HTTPS in clone tab from source repo.

```sh
git remote add upstream https://github.com/bukped/geojson.git
```

before pull request and working in your repo, always do

```sh
git fetch upstream
git checkout main
git merge upstream/main
```

After that you may pull request.

