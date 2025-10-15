# Prerequisites
!!! warning

    Getting an account can take a few days and if you're not accessing through
    your University getting access to the Chalmers VPN can also take a few
    days. Start on this in time.

This LLM-Workshop is an advanced course in the sense that we expect basic
familiarity with some concepts we will be using. We will cover a very brief
refresher for the most important ones, but this will often not be sufficient to
follow along if you are completely new to the topic.

Additionally, there will be some steps to go through to get access and set up
your environment on the cluster we will be using for this workshop.

1. Complete [getting access](https://www.c3se.chalmers.se/documentation/first_time_users/)
    - This can take some time so start ASAP
    - The relevant project to request access to is <TBD>
    - There is a recording of an old Alvis intro [here](https://play.chalmers.se/media/Introduction-to-Alvis-20250528/0_jq2nuodn)
2. Access the cluster and clone this repository in suitable location.
    - Note that connections are only allowed through SUNET
3. Prepare the workshop container.
4. Prepare the interactive runtime.
5. Submit the sanity check.

## Cloning the repository
Start by [connecting](https://www.c3se.chalmers.se/documentation/connecting/) e.g.
`ssh <CID>@alvis2.c3se.chalmers.se`. When you are on the cluster clone the repository.

```bash
cd path/of/your/choice  # optional
git clone https://github.com/UPPMAX/LLM-workshop.git
cd LLM-workshop
```

## Prepare the workshop container
The easy option is to use the container from project storage:

```bash
cd LLM-workshop/excercises/
ln -s /mimer/NOBACKUP/groups/llm_workshop/llm_workshop.sif .
```

If you don't have access to that you can build the container with:

```bash
cd LLM-workshop/excercises/
apptainer build llm_workshop.sif llm_workshop.def
```

## Prepare the interactive runtime
Environments in the interactive apps are set-up with specific files that are
used when launching the interactive app. See [Alvis documentation](https://www.c3se.chalmers.se/documentation/connecting/ondemand/#interactive-apps).

For this you can do something like:
```bash
cp /portal/vscode/codeserver-container.sh ~/portal/vscode/llm-workshop.sh
nano ~/portal/vscode/llm-workshop.sh  # edit this file to use ~/LLM-workshop/excercises/llm_workshop.sif
```

Finally try launching the VSCode interactive app on <https://alvis.c3se.chalmers.se/>, try
it out and remember to cancel the job when you are done.

## Run the sanity check
```bash
cd LLM-workshop/excercises/
sbatch llm_workshop
```

Check that it has completed successfully with `sacct -X` (`STATE` should be `COMPLETED`).
