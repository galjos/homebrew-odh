class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "e091e6e61b6b10fb618dc6eda4785ad72e38b9b922188c71b46ecf68b103b2a8"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=#{version}
      -X github.com/galjos/odh-cli/internal/version.Commit=1daf921ec183
      -X github.com/galjos/odh-cli/internal/version.Date=2026-06-26T12:33:18Z
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/odh"
    generate_completions_from_executable(bin/"odh", "completion")
  end

  test do
    # Derived from the url, so a release that bumps one but not the other fails
    # here instead of shipping a binary that misreports its own version.
    assert_match "odh #{version}", shell_output("#{bin}/odh version --format text")
    assert_match "odh traffic today --area ueberetsch-unterland", shell_output("#{bin}/odh traffic today --help")
    assert_match "#compdef odh", shell_output("#{bin}/odh completion zsh")
    system bin/"odh", "doctor", "--network=false"
  end
end
