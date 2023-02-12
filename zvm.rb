class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https://github.com/gaetschwartz/zvm/releases/download/0.0.5/zvm-x86_64-macos"
  version "0.0.5"
  sha256 "cdea58fd3ef1dcf5984dbb38c78ad9ccd09895067a4d59ee32fd83503b997c7a"
  license ""

  def install
    bin.install "zvm-x86_64-macos" => "zvm"
  end

  test do
    system "#{bin}/zvm", "--version", "--verbose"
  end
end
