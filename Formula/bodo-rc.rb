# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1018.4055-rc/bodo-darwin-arm64"
  version "2026.1018.4055-rc"
  sha256 "7f1395299578e14a213509186707874be00910aca7dac7882de0aa2403afed22"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1018.4055-rc/bodo-linux-arm64"
      sha256 "6507ff7e2cc8cfa5f73ca388a0f00ca405bde7376110116bee146250ae14d0d2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1018.4055-rc/bodo-linux-x64"
      sha256 "2bb4107c0e9cd92816e581a7da771be5cf26418fd345c8e03eb310a71980eed3"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
