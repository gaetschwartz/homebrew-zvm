class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https://github.com/gaetschwartz/zvm/releases/download/0.0.1-staging.13/zvm-aarch64-macos"
  version "0.0.1-staging.13"
  sha256 "d6488a716d1d3de70a0d547557c5f75e9146eaa4618c953d4024d63d17257519"
  license ""

  def install
    bin.install "zvm-aarch64-macos" => "zvm"
  end

  test do
    system "#{bin}/zvm", "--version", "--verbose"
  end
end
