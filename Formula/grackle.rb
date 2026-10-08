class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.6/grackle-v0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "ebcb54a7803cb3e940d4b4b46e2c0fd1e60e9c30ce5a4a5f35fcec67ef6da7d9"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.6/grackle-v0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "f61eed4853a162c972f7c6d83c84c9e75fdf5ad49b85e81e3f535df69bedd689"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.6/grackle-v0.1.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "12d5a70281fe664a1ad361eb1c28324c03af45ea656989f517887956fdaa9bd9"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.6/grackle-v0.1.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d0b3855c03a2694521c61fd01b08fe73e21d5126a86976bdcef5f81ae1444eb"
    end
  end

  def install
    bin.install "grackle"
  end

  test do
    assert_match "grackle", shell_output("#{bin}/grackle --version")
    assert_match "rules.", shell_output("#{bin}/grackle --list-rules")

    (testpath/"wf.yml").write <<~YAML
      on:
        issue_comment:
          types: [created]
      jobs:
        agent:
          permissions:
            contents: write
          steps:
            - run: pip install aider-chat
            - run: aider --yes --message "$(cat task.md)"
    YAML

    require "json"
    report = JSON.parse(shell_output("#{bin}/grackle --format json #{testpath}/wf.yml", 1))
    refute_empty report, "grackle should flag a fork-triggerable write-capable agent"
  end
end
