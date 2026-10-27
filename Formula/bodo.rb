# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4504/bodo-darwin-arm64"
  version "2026.1027.4504"
  sha256 "0d658bdb7144114619801c7247d60919ab8a102fc622603ab3732783befdc1ab"
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
      url "https://cli.bodo-app.com/v/2026.1027.4504/bodo-linux-arm64"
      sha256 "a4902a1e4d4f7d4941a47d418f8a65117109e4212c9d05213c8ec11d2b6ae0d8"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4504/bodo-linux-x64"
      sha256 "13000959c57fef14652187443a80f768df0df3006f750a69a95efffd7aca7041"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
