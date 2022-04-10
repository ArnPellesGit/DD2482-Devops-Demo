package surge

import (
	"dagger.io/dagger"
	"dagger.io/dagger/core"
	"universe.dagger.io/alpine"
	"universe.dagger.io/docker"
	//"universe.dagger.io/bash"
	"universe.dagger.io/python"
)

#Deploy: {
    contents: dagger.#FS

    project: string
    token: dagger.#Secret

    _build: docker.#Build & {
        steps: [
                alpine.#Build & {
                        packages: {
                            bash: {}
                            curl: {}
                            jq: {}
                            npm: {}
                            python: {
                                version: "3"
                            }
                        }
                },
                docker.#Run & {
                    command: {
                        name: "npm"
                        args: ["-g", "install", "surge"]
                    }
                },
            ]
    }

    container: python.#Run & {
        input: _build.output
        script: {
                _load: core.#Source & {
                        path: "."
                        include: ["*.py"]
                }
                directory: _load.output
                filename: "deploy.py"
        }

        always: true
        env: {
            SURGE_PROJECT: project
        }
        workdir: "/src"
        mounts: {
            "Site contents": {
                    dest: "/src"
                    "contents": contents
            }
            "token": {
                dest: "/run/secrets/token"
                contents: token
            }
        }

        export: files: {
            "/surge/deployUrl":     _
        }
    }

    deployUrl: container.export.files."/surge/deployUrl"
}
