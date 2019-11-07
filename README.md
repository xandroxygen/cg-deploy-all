# cg-deploy-all

> Deploy multiple environments at once in a Cloudgate app.

> Note: Cloudgate is an internal app for Instructure software and is only used there.

## Installation

```
git clone <this repo>
cd cg-deploy-all
bundle install
rake install
```

## Usage

`cg-deploy-all` is meant for use with Cloudgate apps, and as such requires that it be ran
in a directory that is a Git repository, contains a Cloudgate app, and that AWS 
credentials are loaded (for an easy way to do that, see [`vaulted`](https://github.com/miquella/vaulted)).

```
cg-deploy-all -h
```

You can pass comma-separated envs to `-e`, like `beta,prod`, or pass a wildcard like `beta-*`.

## Why

It's a hassle to open multiple terminal windows to deploy to multiple envs or wait and deploy
them one after another. This is a simple cli app that just passes its arguments to
`cg deploy`.