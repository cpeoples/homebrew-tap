class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.7/grackle-v0.1.7-aarch64-apple-darwin.tar.gz"
      sha256 "8e64b4a8deaf2aa84b42145b9e0c97167f5966138a57bd1615cac2afab2001ac"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.7/grackle-v0.1.7-x86_64-apple-darwin.tar.gz"
      sha256 "9942d0356cf6d963e779ce2a5c0db701f8d37ee74c219b5b48b3ee873d9a1b26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.7/grackle-v0.1.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "462195995bbd9ad481cd6a2125fc2cb57dec103bd271bae1d83bf51bfe42d9e9"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.7/grackle-v0.1.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "984213b970add67bda66380bdb0381dddbf869987cda843e02c935cecc7fc704"
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
