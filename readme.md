# HelloWorldAction

This is a simple _HelloWorld_ example GitHub action.

Steps to create the _HelloWorld_ GitHub action:

1. Create a new repository.
2. Clone the repo to your local machine.
3. Create _PowerShell_ code.
    ```powershell
    param (
        [Parameter()]
        $Name
    )

    $message = "Hello $Name from a GitHub action!"

    echo "::set-output name=message::$message"
    ```

4. Add an `action.yaml` file with the follwing contents:
    ```yaml
    name: 'HelloWorldAction'
    description: 'HelloWorldDemoAction'
    inputs:
    name: 
        description:  'Your name'
        required: false
    outputs:
    message:
        description: "A simple output message"
        value: "${{ steps.helloworldaction.outputs.message }}"
    runs:
    using: "composite"
    steps:
        - id: helloworldaction
        run: ${{ github.action_path }}/helloWorld.ps1 -name ${{ inputs.name }} 
        shell: pwsh
    ```

5. On the shell, enter: `git add .`
6. Enter: `git commit -m 'initial release`
7. Enter: `git tag -a -m "version 0.1" `
8. Enter: `git push --follow-tags`
9. Go to the repo where you want the action to be executed. 
10. Click on the `Actions -> Setup a workflow yourself`
11. Enter the workflow name. _Workflow.yaml_.
12. Specify the content of the workflow as follows:
    ```yaml
    name: Custom Release Workflow

    on:
    push:
        branches:
        - main

    jobs:
    run-custom-action:

        runs-on: ubuntu-latest

        steps:
        - name: Run HelloWorldAction
            id: helloworldaction
            uses: JeroenBL/HelloWorldAction@v0.1
            with:
            UserName: JeroenBL

        - name: Output message
            run: echo "${{ steps.helloworldaction.outputs.message }}"
    ```