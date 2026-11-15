# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1115.4734/bodo-darwin-arm64"
  version "2026.1115.4734"
  sha256 "dedebe3f4bbdfbb2c5fce3e0bff6509afd8cdfdc28478c837b0348fde6960a2f"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1115.4734/bodo-linux-arm64"
      sha256 "6af24a36d92ae6d7e71b2f2e37ef54a68229150453d054147ea2a06673de9be8"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1115.4734/bodo-linux-x64"
      sha256 "e6c9c0965b672b63543ead9e4563157445fe739a00c9f7b241cf128199e20707"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
