---
tags:
  - session
  - setup
  - set up
  - rendering
  - MkDocs
  - gh-pages
  - deploy
---

# How to setup the rendering of the website

This repository automatically deploys
a nicely rendered website upon each change.

## Step 1: Setup deploy branch `gh-pages`

To set this up, we need to click 10x and type 8 characters.

- At the GitHub repository page, click 'Settings'

???- question "Where is that?"

    'Settings' is found at the top-left of the screen

    ![Click on 'Settings'](click_settings.png)

???- question "I do not see 'Settings'"

    This means you do not have the access rights to do so.

- In the 'Settings' menu, click 'Pages'

???- question "Where is that?"

    'Pages' is found at the left menu list

    !['Pages' is found at the left menu list](settings_click_pages.png)


- In the 'Pages' menu, click 'Branch'

???- question "Where is that?"

    'Branch' is found at the top of the page.

    !['Branch' is found at the top of the page](pages_click_branch.png)

- Try to change the branch to `gh-pages` and fail:
  it will probably say 'No results found'

???- question "How does that look like?"

    Here the branch `gh-pages` cannot be found:

    ![The branch `gh-pages` cannot be found](cannot_change_branch_to_gh-pages.png)

- At the main page of the repository, click on the combobox
  of which branch is actively displayed.
  It will likely display the word `main`

???- question "How does that look like?"

    Here is the combobox of the actively displayed branch:

    ![The combobox of the actively displayed branch](repo_click_branch.png)

- Click on the empty edit line above the branch(es)
  to edit it

???- question "How does that look like?"

    The empty edit line above the branch `main`:

    ![The empty edit line above the branch](repo_branch_edit_empty.png)

- Type the word `gh-pages`

???- question "How does that look like?"

    The word `gh-pages` has been typed.

    ![The word `gh-pages` has been typed](repo_branch_create_gh-pages.png)

- Click on 'Create branch `gh-pages` from `main`

???- question "How does that look like?"

    Click on 'Create branch `gh-pages` from `main`.

    ![Click on 'Create branch `gh-pages` from `main`](repo_create_branch_gh-pages_from_main.png)

- Go to 'Settings | Pages' and observe that `gh-pages`
  is now there

???- question "How does that look like?"

    The 'Pages' page shows that `gh-pages` is used.

    ![The 'Pages' page shows that `gh-pages` is used](settings_branch_set_to_gh-pages.png)


## Step 2: allow a bot to deploy

- In the 'Settings' tab, click 'Actions'

???- question "How does that look like?"

    Click on 'Actions'

    ![Click on 'Actions'](settings_click_actions.png)

- In the 'Settings | Actions' menu dropdown item, click 'General'
  to go the general Actions setting.

???- question "Where do I click?"

    Click on 'General'

    ![Click on 'General'](settings_click_actions_general.png)

???- question "How does that look like?"

    The general Actions settings look like this.

    ![The general Actions settings](settings_clicked_actions_general.png)

- Scroll down to 'Workflow permissions'.
  Click on 'Read and write'.

???- question "Where do I click?"

    Click on 'Read and write'.

    ![Click on 'Read and write'](actions_setting_workflow_permissions_click_read_and_write.png)

???- question "How does that look like?"

    Clicked on 'Read and write'.

    ![Clicked on 'Read and write'](actions_setting_workflow_permissions_clicked_read_and_write.png)
actions_setting_workflow_permissions_clicked_read_and_write.png

Done!

Next time when there is a change in the repository,
the nicely rendered website is deployed automatically.
