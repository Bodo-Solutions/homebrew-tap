# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1118.4748/bodo-darwin-arm64"
  version "2026.1118.4748"
  sha256 "4cbbdaa0385c8cd26204f50f77fb224fc46e80438dd89803d1454a90409b85da"
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
      url "https://cli.bodo-app.com/v/2026.1118.4748/bodo-linux-arm64"
      sha256 "84fb021361ce06dab5b2b9616e532fe3ae781094bb7414e86063646983659204"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1118.4748/bodo-linux-x64"
      sha256 "07f13d776f625cab4360e0d0a88e5bafcad46fc90a4d80acf64694c905da0fe2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
