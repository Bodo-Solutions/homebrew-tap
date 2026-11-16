# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1116.4743/bodo-darwin-arm64"
  version "2026.1116.4743"
  sha256 "9b2cca158e6dd6202811ed73b1b5fa76712bafe00a33843d44f2dba5fa5ed657"
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
      url "https://cli.bodo-app.com/v/2026.1116.4743/bodo-linux-arm64"
      sha256 "d40855954e7fd08ad6bcc29e8da4eff39c91bf1fe7582bc140589fa410b64e39"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1116.4743/bodo-linux-x64"
      sha256 "b26cc0cb576762ddc1355f3426bc93c42e55efdaf9bf3812cdb05b9013b8689c"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
