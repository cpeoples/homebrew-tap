class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.3/grackle-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "485ef7e8fc244d4a9e818404be6f00459ef252d26c8ffef61bef9632fec0faf2"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.3/grackle-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "4ce987ed49f8e1e47435debf0e884205e75809ae8230791eda6f99fa20569a2a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.3/grackle-v0.1.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1533abe072f16cc640b847e12b46f01ed266502c62b49a93d0e818693eb3a210"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.3/grackle-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "50cdaa952038f4b9993807869f2e14a443120ec50b78d9adb36ebab1897156f5"
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
