class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https:/github.com/gaetschwartz/zvm/archive/0.2.2.tar.gz"
  sha256 "2a14ad56efdbb08a19822e5b3ce688b3ceb6ec889337b21aeb2290c18a256443"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-aarch64-0.11.0-dev.1606+3c2a43fdc.tar.xz"
        sha256 "203bd59d6073346c8a23ab3f5507c8667682a857a7bbc39423df0f8388840fd0"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-x86_64-0.11.0-dev.1606+3c2a43fdc.tar.xz"
        sha256 "6e66506952ba89f3ee83753739db223e326a264a47d28d382a729720aa0152f9"
      end
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-aarch64-0.11.0-dev.1606+3c2a43fdc.tar.xz"
        sha256 "2d116916f95c684cd663801425341e55085810e50126740c94ce5b669c5dc712"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-x86-0.11.0-dev.1606+3c2a43fdc.tar.xz"
        sha256 "3ed621c4443a46d6058bdc08cb0f06f7fba6063cad6b6b93ac2cf6035220262b"
      end
    end
  end

  resource "known-folders" do
    url "https://github.com/ziglibs/known-folders/archive/53fe3b676f32e59d46f4fd201d7ab200e5f6cb98.tar.gz"
    sha256 "3c9d1e293df9e3e48b96114859267c2bf5d8cc924e7e5f7a9628d0c77bb43709"
  end

  def install
    resource("zig").unpack "ziglang-org/zig"
    resource("known-folders").unpack "known-folders"
    system "ziglang-org/zig/zig", "build", "-Doptimize=ReleaseSafe"
    bin.install "zig-out/bin/zvm"
  end

  test do
    system "#{bin}/zvm", "--version", "--verbose"
  end
end
