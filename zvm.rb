class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https://github.com/gaetschwartz/zvm/releases/download/0.0.1-staging.14/zvm-aarch64-macos"
  version "0.0.1-staging.14"
  sha256 "1d5990e8a1cd7a1e1edc7dcc89e47b5344583cfbdf0696bb8d1ac3c960eb8bd2"
  license ""

  def install
    bin.install "zvm-aarch64-macos" => "zvm"
  end

  test do
    system "#{bin}/zvm", "--version", "--verbose"
  end
end
