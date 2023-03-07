class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https:/github.com/gaetschwartz/zvm/archive/v0.2.13.tar.gz"
  sha256 "c2ba190a5f4ad2779d84ff7a138ce8867368fba99e67db84afe3b874292e52d0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-aarch64-0.11.0-dev.1857+010596c93.tar.xz"
        sha256 "6c3cb94abca2d743b7ef1879a6ce526d3e509cbbeacd7dbddd8e89ee063330dc"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-x86_64-0.11.0-dev.1857+010596c93.tar.xz"
        sha256 "274510a486259de58ff0fabd2cf73786975eeec9afa6124b02eeac27609515e6"
      end
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-aarch64-0.11.0-dev.1857+010596c93.tar.xz"
        sha256 "fbf4da87e44a39c6d6f63a21009fe4fcb52cfabbd3a2179b358cdceba1471879"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-x86_64-0.11.0-dev.1857+010596c93.tar.xz"
        sha256 "9b925ef92e5405b68b07f7fa56b8e12db55937bfac26947472ef8c2b5447816a"
      end
    end
  end

  def install
    resource("zig").unpack "ziglang-org/zig"
    ohai "Building zvm... (this may take a while)"
    system "ziglang-org/zig/zig", "build", "-Doptimize=ReleaseSafe"
    bin.install "zig-out/bin/zvm"
    generate_completions_from_executable(bin/"zvm", "completions", "--shell", "zsh", shells: [:zsh])
  end

  test do
    system "#{bin}/zvm", "--version"
  end
end
