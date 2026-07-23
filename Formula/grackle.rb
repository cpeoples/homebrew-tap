class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.2/grackle-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "4320edc54f186127607a2ce0671cf1b19a9f55577f3a29398a16da8879589f0f"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.2/grackle-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "834449be07b54995aaf220aabbe933f2fa67354edc3c483dd0634a85a68c34b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.2/grackle-v0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1d0c2eca9e206f70f9ee6656f878861d7e543fe95d732d279f94a26f16666327"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.2/grackle-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "47dfe4cc6c68b0ef79dd404d93a043e57bf66789814a1c7975f3233f172e3da2"
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
