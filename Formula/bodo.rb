# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4305/bodo-darwin-arm64"
  version "2026.1023.4305"
  sha256 "b9d5bb38064d1a41a770f4fc5d0de3f64fc1564e0adff407a2930760e5c278be"
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
      url "https://cli.bodo-app.com/v/2026.1023.4305/bodo-linux-arm64"
      sha256 "893d0bd40f4546628f308a2890adf762f8ada15d87088bdec64bf2c259599ec3"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4305/bodo-linux-x64"
      sha256 "17281d8b8bbd141953bba536c074f57efd3f1585197c26dc3e92cdf8c86befce"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
