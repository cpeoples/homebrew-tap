class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.4/grackle-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "304e8f7e19b3c540589fbf354ebe68ee8596372818706e2b81c9ea66e56da91d"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.4/grackle-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "45f32e12b25442f238f9edfa4156bf39dfbf0ddaed29aaa5d42756643162b0ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.4/grackle-v0.1.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73a8b77dff7e166887c69e06fdc3f5182a8d63589308da7da9d303efc0c14078"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.4/grackle-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fe9f9f060df90df207333edab0a3809e336cdd7affff6520dde0cfe32199a9c9"
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
