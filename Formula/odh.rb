class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "cc502871ddc68f76f3c3468632ad0a7c779a0cef0ed0f736453adae487264ed6"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=0.2.2
      -X github.com/galjos/odh-cli/internal/version.Commit=a32e3560e8d0
      -X github.com/galjos/odh-cli/internal/version.Date=2026-05-26T14:02:37Z
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/odh"
  end

  test do
    assert_match "odh 0.2.2", shell_output("#{bin}/odh version --format text")
    system bin/"odh", "doctor", "--network=false"
  end
end
