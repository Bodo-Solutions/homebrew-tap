# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1020.4134/bodo-darwin-arm64"
  version "2026.1020.4134"
  sha256 "6c6a85681e242b01f85e8e3a2a1abe46bf4f6b5956f1c41e4c383455fc63d81b"
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
      url "https://cli.bodo-app.com/v/2026.1020.4134/bodo-linux-arm64"
      sha256 "0d3752a63f67335e62575fbc370b4d4bd6e19c0d6cbb5e9f62493c88c69668f6"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1020.4134/bodo-linux-x64"
      sha256 "f7fd8a290cf588adf256e7e29c6be79ada24f894b74fb799fc2a3047c81e1b82"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
