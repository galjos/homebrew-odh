class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "cef29af50597d6a12d634da465a49bdfe297dd17968bb763b482013b63642663"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %w[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=0.2.1
      -X github.com/galjos/odh-cli/internal/version.Commit=60d32b874d31
      -X github.com/galjos/odh-cli/internal/version.Date=2026-05-26T13:33:22Z
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/odh"
  end

  test do
    assert_match "odh 0.2.1", shell_output("#{bin}/odh version --format text")
    system bin/"odh", "doctor", "--network=false"
  end
end
