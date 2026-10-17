class Cudabom < Formula
  desc "CUDA bill of materials: identify CUDA components and match known advisories"
  homepage "https://github.com/cpeoples/cudabom"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "bc9044d6402b53ff27003aa873fc940a72d166cdaa52a6a2764ed425793fcb74"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "542d8caae2cc50f80c9e6d5155b4499ec4bca08f0fbdf71fd32e7f6b7403225f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "20ea6f851d576e5c03417689395cde009d994a53066351770535bea1b29a2d50"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "67075fd72730633f8fe861104e467594ccc7580aa78b1560f308a8e184943085"
    end
  end

  def install
    bin.install "cudabom"
  end

  test do
    assert_match "cudabom", shell_output("#{bin}/cudabom version")
    assert_match "scan", shell_output("#{bin}/cudabom --help")
  end
end
