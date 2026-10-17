class Cudabom < Formula
  desc "CUDA bill of materials: identify CUDA components and match known advisories"
  homepage "https://github.com/cpeoples/cudabom"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "94c0073abf823414f28646851a606774b2868915eaf286c7213817364a0be87c"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "d69dcc7238fcbd1acf93cd209a5463bb39217b57828f5ee4a7d06ee1ca3be2f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "25f1de25bed99a18de1144527daa5084b4301ae768381219787c248f82c0bfa4"
    end
    on_intel do
      url "https://github.com/cpeoples/cudabom/releases/download/v0.1.0/cudabom-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9baccfd2f92394fc5ec0b01cf37f0b0651b95363d64e9bc998ab94b6c9b2a19"
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
