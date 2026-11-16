class Grackle < Formula
  desc "Detects fork-triggerable CI coding agents that can write to the repository"
  homepage "https://github.com/cpeoples/grackle"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.8/grackle-v0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "dc2acef8edcefd90768bbe3a0338b60ef9d5f902d41f0290b741933c9c622a48"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.8/grackle-v0.1.8-x86_64-apple-darwin.tar.gz"
      sha256 "94c1195f81d93ba558138b22f41813e841d22cc6a85449a0eddf805eb08ae85a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.8/grackle-v0.1.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ab51b38df9659bf06093d069c2dd4de4c8c24fb7f86a6a4eb6195507a820e8fa"
    end
    on_intel do
      url "https://github.com/cpeoples/grackle/releases/download/v0.1.8/grackle-v0.1.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f1d720991180182eeb7b2f5a01d93bdfab589b304121b7674720b89386939a4e"
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
