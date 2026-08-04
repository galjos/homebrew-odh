class Odh < Formula
  desc "Agent-friendly CLI for public Open Data Hub APIs"
  homepage "https://github.com/galjos/odh-cli"
  url "https://github.com/galjos/odh-cli/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "2845cb99b9216c3fe6eeb675b8f4479b747cf2349220b57b9ec87856d79f726b"
  license "MPL-2.0"
  head "https://github.com/galjos/odh-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/galjos/odh-cli/internal/version.Version=#{version}
      -X github.com/galjos/odh-cli/internal/version.Commit=88f54601b9ec
      -X github.com/galjos/odh-cli/internal/version.Date=2026-08-04T08:21:02Z
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
