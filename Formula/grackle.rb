class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.1/grackle-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "fc5f482f7211505b2fecd538bb2fcfcd63f2e34522d55cd7146233ca920452a5"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.1/grackle-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "f859930dba5bff636a9e1be545a72f8338338be015faffd6098a820cab2a9e62"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.1/grackle-v0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0f905c529182e082e0639a7f4155d0d50af76b80ab4e33b3f116e8c3ada60283"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.1/grackle-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "601913e2706613a91ff3c737e4d246a6cd2b8f4d7125d73e45922982c13f2174"
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
